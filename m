From: "Zhang, Jian" <jzhang@ti.com>
Subject: RE: status of OMAP ALSA support
Date: Fri, 11 Aug 2006 17:56:51 -0500
Message-ID: <304D2A85A9643F4A991BDDF8D297BBA6040F63E8@dlee05.ent.ti.com>
References: <77C7F7CB1230A74A9D19C0C111E6EDBEF153EC@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <77C7F7CB1230A74A9D19C0C111E6EDBEF153EC@DLEE09.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Mika,

Thanks for the response. I have overlooked this email until today.

Good to know it is tested on H2. I should be able to get a H2. I tried
to build a H3 kernel with tsc2101 codec. The alsa core reported no sound
card. It seems that snd_card_new() fails silently in omap alsa core.=20

I don't have any fixes yet. I can add H3/H4 support once I first have it
run on H2 (I am new to sound so need some tracing of control flow:)) The
current focus is to understand ALSA. I have asked you a dummy
configuration question in a separate email. Any help from you is
appreciated.  =20

Will work with you once I am on the way.

Regards,
Jian

-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com
[mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
lamikr
Sent: Wednesday, August 09, 2006 7:42 PM
To: Zhang, Jian
Cc: linux-omap-open-source@linux.omap.com
Subject: Re: status of OMAP ALSA support

Zhang, Jian wrote:
> Hi,
>
> Does OMAP ALSA driver work? Neither H4 nor H3 has it in default
> configuration.
>  =20
Yes, the aic23 has been tested with board-osk and tsc2101 has been
tested
with the board-osk and board-h6300. (h6300 specific code is not yet send
to omap-kernel list,
but you can check the h6300 port of omap 2.6.16 kernel it by using
command:
svn export svn://fuzzyneural.net/h6300/omap-linux/branches/h6300_dev

> I see the following in tsc2101 codec driver:
>
> codec_cfg =3D pdev->dev.platform_data;
> if (codec_cfg !=3D NULL) {
>  ...
> }
> else
> ret =3D -ENODEV;
>
> I don't see any code to set up dev.platform_data. As a result,
codec_cfg
> is always NULL and OMAP ALSA should not work at all.=20
>  =20
It should be pretty easy to add the support also for other omap boards
if you
just know the correct MCBSP settings. I have not access to h3 or h4
boards so
I have not been able to test them. Do you have access to that data?

I have however send once the patches adding a similar kind of support
for the Innovator and 770 boards that are using aic23 chipset.
Innovator patches has been tested to work by James Selvam.

According to one message in maemo developer list, somebody build &
tested also the 770 patch and was able to hear some kind of noice but
not correct sound.
(mcbsp settings were probably incorrect for that board). It seems that
n770 uses anyway some other driver for the sounds by default, so I have
not investigated this further.

> I might miss something here. Please comment.
>
> Other than that, it seems to have the following limitations by looking
> at the code statically.
> - omap-alsa.c knows the codec connectivity detail (hard-coded to
> MCBSP1). This file should be independent of board specifics.
>  =20
Maybe that info could also be set-up either during the kernel
configuration phase or in board-file.
> - Dead lock as s->dma_lock is double locked in multiple locations.
>  =20
Hmm, I have not noticed any dead locks. With my h6300 I need however
stop sound dma in every round in audio_process_dma() function.
(and according to innovator tests by James Selvam, other omap1510
devices needs to do also the same)

> - Don't support duplex as codec lock is shut off when either input
> stream or output stream is closed.
>  =20
Do you have any patches for these? If you want I could also try to work
with you to fix these issues.
> - Memory strategy is very rudimental: Hard-coded to allocate 128KB
> consistent memory in init time.
>  =20
Would you like to specify this also in the board file?

Mika
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
