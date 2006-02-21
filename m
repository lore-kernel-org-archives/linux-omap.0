From: "Daniel Petrini" <d.pensator@gmail.com>
Subject: Re: [PATCH] Alsa modularisations and support for tsc2101 0/7
Date: Tue, 21 Feb 2006 09:49:16 -0400
Message-ID: <9268368b0602210549lfea6644we3454248938f8d3c@mail.gmail.com>
References: <9268368b0602200933s41905c2bp254749b1e6eff9c7@mail.gmail.com>
	<520AB2AD990DC04082102F77CA1726381036EA@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726381036EA@dlee03.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Menon, Nishanth" <x0nishan@ti.com>
Cc: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Nishanth,

On 2/21/06, Menon, Nishanth <x0nishan@ti.com> wrote:
>
>
> Hi Daniel,
> Glad to see a clean organization coming in for the code :).
> >2) If it is acceptable to put the codecs under arch directory, would
> >plat-omap be better location than arch-omap1, for mcbsp supported
> >codecs? (Are there any omap2 boards with aic23 or tsc2101 codecs?)
> Yes, There are omap2 boards with tsc2101, and omap2 boards which can have
> pluggable codecs.

Yes, we can put that files in plat-omap instead.

>some interesting observations I have seen so far (it will
> be a small set compared to what others could add):

Good separation of functionalities it is more or less what we are
thinking about.

> Control paths:
> McSPI, uWire, I2C

This control path are mainly used by the codec file

> Data transfer paths:
> codecs with mcbsp/EAC on 2420
> codecs with mcbsp/mcbsplp(on2430)
> codecs on mcbsp1,2

Yes, they act as "bridges" between the main processor and the codec.
Maybe a future version of the modularisation will be responsible to
remove the dependence of mcbsp.

> Data formats:
> PCM,I2S,TDM
> could have supported uLaw data formats too
> Codecs:
> tsc2101, aic, others such as
> twl4030(http://focus.ti.com/general/docs/wtbu/wtbugencontent.tsp?template=
Id=3D6123&path=3Dtemplatedata/cm/general/data/wtbmiddl/twl4030&DCMP=3DWTBU&=
HQS=3DProductBulletin+OT+twl4030)codecs
> which are far more complex than these two, including data mixing,
> mono/stereo input/output capabilities.

Yes, isolating they from alsa is the first step.

> Regards,
> Nishanth Menon

Regards,
Daniel
--
INdT - Manaus - Brazil
