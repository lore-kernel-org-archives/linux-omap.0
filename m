From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: Myir AM437x Rico board support for Linux 4.1 kernel
Date: Thu, 3 Sep 2015 14:40:15 +0300
Message-ID: <55E8319F.6030002@ti.com>
References: <201508251539.41234.ppisa4lists@pikron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201508251539.41234.ppisa4lists-hnFyeMMZ0rvQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pavel Pisa <ppisa4lists-hnFyeMMZ0rvQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dan Murphy <DMurphy-l0cyMroinI0@public.gmane.org>, support-0A6ZgDe55FJWk0Htik3J/w@public.gmane.org, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kevin Su <kevin.su-0A6ZgDe55FJWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

+Tony, Tomi, linux-omap

Hi Pavel,

On 25/08/15 16:39, Pavel Pisa wrote:
> Hello everybody,
> 
> I have been asked to help with Linux on Myir Rico board.
> I have decided to try actual stable kernel from Ti tree
> 
>   git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git
>      branch ti-linux-4.1.y
> 
> instead of delivered dated 3.12.10 one to solve some issues
> and have chance to port possible enhancements to mainline.
> 
> I have successfully prepared environment which loads kernel
> over TFTP and boot actual Debian Jessie armhf from NFS export.
> 
> Because I have not found up to date device tree for this
> board I have analyzed delivered sources against best matching
> Ti kernel and then prepared DTS which works on the board
> and I want to know if somebody works on this support, can help
> to finish/better tune parameters and if there is chance
> that configs are included into mainline or some other public
> repository. Because I do not know who is working on this support
> and who is right maintainer I send only pointers to my files.

Tony Lindgren is the OMAP platform maintainer and you must
include linux-omap mailing list in in the discussion.

> 
> http://cmp.felk.cvut.cz/~pisa/arm/myir-rico/am437x-myir-ricoboard.dts
>  based on Ti am437x-gp-evm.dts
> 
> http://cmp.felk.cvut.cz/~pisa/arm/myir-rico/am437x-myir-ricoboard-hdmi.dts
>  based on Ti am437x-gp-evm-hdmi.dts
> 
> http://cmp.felk.cvut.cz/~pisa/arm/myir-rico/am437x-myir-ricoboard_defconfig
> 
> If there is interrest for discussion and inclusion, I send usual
> inlined GIT patches series.

Please send patches for the new board so that we can review.

> 
> As for DTS, I expect that the regulators section does not match correctly
> Rico board HW but it works for what client company needs
>   evm_v3_3d: fixedregulator-v3_3d
>   vtt_fixed: fixedregulator-vtt
> 
> Ethernet, serials, cameras, local MTD, SDcard and most of other devices works.
> SPI Flash does not work. I have not invested time to that.
> 
> The client needs to connect special camera (infrared) to the VPFE so I have
> spent some time on AM437x VPFE support enhancement.
> 
> I have added V4L2_PIX_FMT_Y10 pixel format and some minimal/stub 
> implementation of vpfe_enum_frameintervals, vpfe_g_parm, vvpfe_s_parm, 
> pfe_s_parm and I would be happy if my work can help to somebody other
> as well. But work has been driven strict deadline to provide working
> solution in one week so if there is interrest then most has to be
> rewritten/clean up.
> 
> Generally, I am quite pleased by Ti's Linux tree state and support.
> That week has been my first time with AM chips we used other archs
> (powerpc and multiple i.MXs for most of our other projects till now).
> 
> Probably off topic for these lists but what are suggested options
> for graphic configuration when Qt4/E or Qt5 is run on framebuffer.
> Is it better to use CONFIG_DRM_OMAP or CONFIG_FB_OMAP2 ?
> Is SGX driver available for 4.1 Linux kernel (reply offlist, please,
> if proprietary only)? Are there other possibilities how to use
> OMAP AM437xx hardware to accelerate video color and formats
> transformations? Can be VPFE planes used somehow to embed
> video in Qt application? I, personally, prefer strongly
> opensource only options but target company has probably minimal
> requirements in this area.

Tomi might be able to answer video related questions.

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
