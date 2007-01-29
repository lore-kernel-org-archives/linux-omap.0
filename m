From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: Noise causes gpio interrupt
Date: Mon, 29 Jan 2007 15:01:17 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D913027429376608@dlee13.ent.ti.com>
References: <740992.7549.qm@web55304.mail.re4.yahoo.com>
	<45BA0CFA.5010409@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <45BA0CFA.5010409@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>, Arnold <abo_gwapo@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

I generally interpret this to mean you can go low, high, low to fast
else you will miss your high.  This is not what was indicated but it
could be what is happening.  Your 'high' state must also obviously cross
the signaling threshold value also.

If you go low to high quickly I'm not aware of that being an issue.  You
just don't see it for a couple of gpio clocks (assuming you stay high
long enough).

It might be possible that the interrupt was dropped somewhere in
software.  Back in 1510/5910 days this was possible given the way Linux
configured things up and serviced interrupts (mismatch of internal
polarity to configured ones along with quickly unmasked interrupts).
This shouldn't be an issue for later ones like OMAP2 which hook them all
internally as level and only offer edge's on external lines.  MV code at
one point tried to peek at status registers and re-trigger to identify
edges.  I've not looked at what the current code path is for open source
versions here.

You may have a couple types of GPIOs, used to have ARMIO/MPUIO and GPIO.
You might try moving your source to some different pins and see if they
all behave the same way.

If you have a debugger, you really should be able to sit in a stopped
state then make a fast trigger event.  Then you should be able to read
the GPIO registers directly and see if the event was caught.  It almost
certainly will be.

In the end I'd guess your source isn't driving the line high enough for
the interrupt pulse, or the pulse width is to short.  I don't think the
slope of the pulse should matter.  Just that it goes high enough for a
long enough time before falling.

Regards,
Richard W.

> Arnold wrote:
> > ... However when the interupt comes from a
> > device and the transition of rise to fall is 20ns it
> > could not detect that an interrupt occured. I also
> > tried to increase the transition to 20ms and it was
> > able to detect the interrupt. ...
>=20
> Maybe http://www.ti.com/litv/pdf/spru767a, section 1.6 or
> page 28, can help:
>=20
> "Because of the sample operation with the functional clock,
> the minimum pulse
> width on the input GPIO to trigger a synchronous interrupt
> request is two times
> the functional clock period. This minimum pulse width must
> be met before and
> after any expected level transition detection."
>=20
> Best regards
>=20
> Dirk
