From: Daniel Petrini <d.pensator@gmail.com>
Subject: Re: omap alsa tsc2101 driver
Date: Tue, 7 Feb 2006 18:29:55 -0400
Message-ID: <9268368b0602071429k9563756hc94fbc4efd124aa0@mail.gmail.com>
References: <43E66CF6.8040600@cc.jyu.fi>
	<9268368b0602061113n30e8c49bx756de24a1eaf93c6@mail.gmail.com>
	<43E7AEC3.3020901@cc.jyu.fi>
	<9268368b0602061401m4522d31v258f0f67f19509ef@mail.gmail.com>
	<43E8960E.6090005@cc.jyu.fi>
	<9268368b0602070634g47a53b15w6492c036166f6cb4@mail.gmail.com>
	<43E905A8.9090307@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <43E905A8.9090307@cc.jyu.fi>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lamikr@cc.jyu.fi
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Mika,

On 2/7/06, lamikr <lamikr@cc.jyu.fi> wrote:
> Daniel Petrini wrote:
>
> >Hi,
> >
> >On 2/7/06, lamikr <lamikr@cc.jyu.fi> wrote:
> >
> >
(...)
>
> >Humm, Maybe the problems dwells in this function:
> >omap_get_dma_src_addr_counter
> > (called in alsa-omap driver core file) Please try to analyse its
> >behavior for omap1510, the idea is to get the current position of a
> >dma transfer. Maybe the registers are diferent in 1510 which has
> >different dma engine.
> >
> >
> Thanks for the idea, I will try to investigate it later on today. I just
> checked
> that the OSS code is not relying to omap_get_dma_src_addr_counter()
> function at all
> so that might explain the reason why the oss version works for me.

I guess that the answer might come from there.

> >>Any changes you could also test the playback with my driver version, it
> >>could help me to identify the problem
> >>
> >>
> >
> >I compiled but I can not play yet, I think that my alsa programs are
> >old in my rootfs. I compile them as modules or integrated without
> >success. I will update my rfs.
> >It says: alsactl: load_state:1236: No soundcards found...
> >After I make it run I give you a feedback.
> >
> >
> Hmm, did you remember to change the board code, to register the driver?
> I use here:
> static struct platform_device h6300_mcbsp1_device =3D {
>     .name        =3D "omap_tsc2101_mcbsp",
>     .id        =3D 1,
> };
>
> static struct platform_device *h6300_devices[] __initdata =3D {
>     &h6300_mcbsp1_device,
> };
>

ok. It has worked with that. The song played fine in H2.


Cheers,

Daniel
--
INdT - Manaus - Brazil
