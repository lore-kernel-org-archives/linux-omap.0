From: "K, Mythri P" <mythripk@ti.com>
Subject: Re: [PATCH] OMAPDSS: HDMI: wait for RXDET before putting phy in TX_ON
Date: Fri, 2 Mar 2012 13:35:37 +0530
Message-ID: <CAP5A+B8uqQYq671=TQRm0LsYSfdDMoZY0koU4JH=MpA20HMj2w@mail.gmail.com>
References: <1330589664-15755-1-git-send-email-mythripk@ti.com> <1330601462.2586.32.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:42993 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756719Ab2CBIF5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 03:05:57 -0500
Received: by mail-iy0-f171.google.com with SMTP id j38so2395354iad.30
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 00:05:57 -0800 (PST)
In-Reply-To: <1330601462.2586.32.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Tomi,

On Thu, Mar 1, 2012 at 5:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:
> Hi,
>
> On Thu, 2012-03-01 at 13:44 +0530, mythripk@ti.com wrote:
>> From: Mythri P K <mythripk@ti.com>
>>
>> Currently TX_PHY is put to TX_ON(transmission state) on receiving HP=
D.
>> It just ensures that the TV is connected but does not guarantee
>> that TMDS data lines and clock lines are up and ready for transmissi=
on.
>> Which although is very rare scenario has a potential to =A0damage th=
e HDMI
>> port.(A use case where TV is connected to board but it is in differe=
nt
>> channel would still trigger a HPD but TMDS lines will be down).
>
> When/how does the damaging happen? When the HDMI cable is disconnecte=
d
> in the case above? Or does the damage just happen by having the cable
> connected, but the TV on different channel?

Damage never happens with the cable connected for a long time.. Damage
happens only
when the cable is connected when the PHY is in TX ON state. Which
requires the following sequence to be followed.
1. Wait for HPD connect
2. Wait for the PHY connect ( TMDS lines are up)
3. Enable PHY
We are currently missing step 2.
>> + =A0 =A0 =A0 =A0 =A0 =A0 tmds_clk =3D hdmi_read_reg(hdmi_wp_base(ip=
_data),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 HDMI_WP_WP_DEBUG_DATA);
>> + =A0 =A0 =A0 =A0 =A0 =A0 udelay(15);
>
> This code doesn't make any sense, or the HDMI TRM is wrong. You read =
the
> same register, HDMI_WP_WP_DEBUG_DATA, four times, assigning the value=
 to
> data0-2/clk. The TRM I have doesn't talk about anything like that. Wh=
at
> is the code supposed to do?
>
I am not very sure which TRM you have but the HDMI_WP_WP_DEBUG_DATA
can also be used to probe the TMDS lines as well, but i might as well
try pad config and let you know.
> The register HDMI_TXPHY_PAD_CONFIG_CONTROL also has bits for RXDET_LI=
NE.
> Is that something different?
>
>> + =A0 =A0 } while ((tmds_data0 !=3D tmds_data1 || tmds_data1 !=3D tm=
ds_data2
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || tmds_data1 !=3D tmds_cl=
k) && (loop < 500));
>
> This is a rather confusing way to do the loop. Why not just use for-l=
oop
> with the timeout, and check the tmds variables inside the loop. Much
> easier to read.
>
> In the worst case the above causes a 7.5ms busy loop in an interrupt
> handler. That's not very good thing. Why is there a need for the loop=
?
I agree looping in interrupt context is bad.. That was the reason i
had a threaded irq handler and i case even here it is the threaded irq
handler i dont think it is happening in irq context.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DSSERR("rxdet not set\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return r;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>
> Does this mean that if the user connects a TV which is in a different
> channel than HDMI, the only way for the user to get an image is to
> disconnect the cable and connect it again?
Well If the handling is based on HPD then yes.. Or one another thing
is i can add the core interrupt support and we can then wait on the
PHY_CONNECT instead of all the above scenario.
I shall put a wait_on_completion check in HPD and we can wait till we
get PHY connect.

Thanks and regards,
Mythri.
>
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
