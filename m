From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH 28/28] omap2 clock: handle (almost) all clock autoidling
	viathe clock framework
Date: Tue, 21 Aug 2007 12:29:28 -0500
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742901AD86A6@dlee13.ent.ti.com>
References: <20070820095347.933473149@pwsan.com>
	<20070820095532.728389316@pwsan.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742901AD7C60@dlee13.ent.ti.com>
	<Pine.LNX.4.64.0708210050330.5695@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0708210050330.5695@utopia.booyaka.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Paul,

> On Mon, 20 Aug 2007, Woodruff, Richard wrote:
>=20
> > I thought about doing this back when OMAP1 added this when I was =
more
> > active on OMAP2.  However, I dropped it as it didn't have enough =
'bang'
> > in this form.  I think these registers (even in OMAP1) are widely
> > mis-understood.  This is partially a TRM issue and one of =
complexity.
> >
> > Meaning you can set this register on a per-clock basis however they =
do
> > nothing for run time except at L3/L4 domain change time.  In the
> > OMAP-GIT code this means at retention time the PRCM has permission =
to
> > shut off your ICLK assuming your module acknowledges it.
>=20
> I see.  Thanks for the explanation.  So in practical terms, it seems =
best
> to just enable this for all clocks unconditionally, as before in pm.c, =
no?

Probably so... Given the current surrounding implementation it is not so =
effective and will result in many drivers adding some calls which are =
just noise. Hollow code...

I think even in OMAP1 a similar condition exists, it's been a long while =
since I looked.  But its clock manager bits also allowed auto control =
during only full domain changes to its couple of sleep modes.  One can =
consider an OMAP1 as only have a single big domain where and OMAP2 as =
several and an OMAP3 has many.  Some ideas and techniques have been =
carried forward.

Like I was indicating for OMAP2/3 if the PRCM auto idle was switched =
with the module auto-idle it would not be noise it would be substantive.
	-- One issue here is the address range for this bit is with each driver =
in the _generic_ IP OCP (open core protocol bus interface) wrapper =
header.  To write to this you need i+f clock on.  It still helps to set =
this bit even if the module is off as the clock tree can still be active =
and dissipating some power in the module.
	-- This is what the patch I sent out a while back was about (RFC/PATCH) =
to just enable all of these.  It did save a lot of power.
	-- A PRCM library can provide these access functions
	-- It can be in lined in ever driver
	-- Or the clock frame work can provide an interface for it.
	** As its generic and symmetric for every IP in the OCP wrapper I =
personally like to stick it all in one spot inside of adding a bunch of =
defines to every driver.
	** Recently we internally were debating a bit about if an API was =
needed as you really in some cases do need to set the CLOCKACTIVITY bits =
in the OCP wrapper depending on the drivers mode of activity.

> > If the PM code
> > does this manually (enable/disable) then this register has no =
effect.
>=20
> So, if the clock's enable/disable bit in its ICLKEN register is =
touched in
> any way, the clock auto-idle bit is ignored?  Does that hidden state
> persist until reset?

No, not the way I read your question.

When ICLKEN is enabled and the PRCM-auto-idle is enabled hardware can =
manage that clock at domain change time assuming the peripheral =
handshakes it ok (force/no/smart).

If the ICLKEN is disabled the setting of PRCM-auto-idle has no effect.
=20
> > It does have a useful run time property in that it is one form to =
gate a
> > clock stop state assuming you have not forced it.  This is one way =
to
> > stop a cascade clock stop from happening when you are not expecting =
it.
> > It would be a lighter weight way then the mutex which OMAP2-GIT code
> > uses.  However, for that to work other code would have to change.
>=20
> But that would only happen when going to retention or off, correct?

Given the current OMAP-GIT code this is correct. =20

However this is a bit more to it than that.  These clocks can be =
auto-handled during clock domain stop mode.  The power domains have the =
properties of On/Retention/Off while the clock domains have properties =
of On/Inactive.

The i-clocks controlled by prcm-autoidle can be hardware managed (shut =
down) when the L3 and L4 clock domains go inactive.  The power domains =
can be in any state at this time.  As it likely turns out in the GIT =
code today, the L3/L4 clock domain and the core power domain effectively =
state change at the same time.

One of the big target states for big power savings is this so called =
'partially' active state.  In this case you do want the clock domains =
and the power domains states to not be in sync.  The L3/L4 can be =
stopped, but say an F-Clock to a McBSP can still be running pushing data =
out to a codec.  If programmed up correctly, the codec need for data can =
automatically signal the prcm to re-activate the L3/L4 then allow the =
new data to flow.  This is the 10mA vs. 200mA kind of thing I was =
describing (you do need to clear the wake up status for it to happen =
again).  When you hit 'retention' or OFF your currents are in the =
50-100uA range, but there is absolutely no activity.

> > Each IP-Module _does_ have an AUTOIDLE bit in its SYSCONIG space =
which
> > does act as you might expect this bit to.  Setting this AUTOIDLE =
does
> > save significant power.  It would be more useful to control that one
> > from here.
>=20
> Those cover potentially large numbers of clocks...  So in lieu of a =
more
> general power domain API, is there a reason not to set all of those =
bits
> unconditionally in pm.c?

In the general case for this bit it turns out that you can set it at =
init time.  Some bug work around might require some access.

However, other bits in the same range CLOCKACTIVTY do have a bit more =
need of dynamic access.  WE enable also might be conditionally set.  =
Also the handshakes sometimes take different settings =
(smart/force/no-idle/standby) for some bug work arounds (software or =
hardware).  A force idle might clear some internal status in say a HSMMC =
which a driver didn't fully clear out.

Regards,
Richard W.
