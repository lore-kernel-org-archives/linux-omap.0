From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: Zoom, crop and scaling v4l2 device capabilities
Date: Mon, 2 Apr 2007 16:02:59 -0400
Message-ID: <a0580c510704021302me0ae0a1k441240db6a251b20@mail.gmail.com>
References: <a0580c510704021208p2ea32c9cma87fad250a687226@mail.gmail.com>
	<4044722E22DAA544B0D1A88BE9CE24DD113007@dlee15.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4044722E22DAA544B0D1A88BE9CE24DD113007@dlee15.ent.ti.com>
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
To: "Zhang, Jian" <jzhang@ti.com>
Cc: Linux OMAP ML <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello Jian,

   Thanks for your response. I saw David post, but currently, there is
only one reference for crop under drivers/media/video/omap into
linux-omap tree.
   Was the crop support dropped? Why? Were you facing problems with it?


Cheers,

Eduardo Valentin


On 4/2/07, Zhang, Jian <jzhang@ti.com> wrote:
>
>
> Yes, you can do what you wanted via CROP abd FMT IOCTLS. We have
> supported this feature one year ago. The camera patch from David has it.
>
> For your cases, your crop bundary will be (0,0)(640, 480) then:
> - mode 1 (640, 480),
> FMT has 640*480, crop is the same as crop boundary.
> - mode 2 (320, 240) from window (0,0) to (640, 480) and
> FMT has 320*240. crop is the same as crop boundary. You will scale
> 640*480 down to 320*240. You have the full filed-of-view.
> - mode 3 (320, 240) from  window (161, 121) to (480, 360)
> FMT has 320*240. crop is the (161, 121) (320, 240). You zoom-in (don't
> have the full filed-of-view.). No scaling.
>
> Regards,
> Jian
> -----Original Message-----
> From: linux-omap-open-source-bounces@linux.omap.com
> [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of
> Eduardo Valentin
> Sent: Monday, April 02, 2007 2:08 PM
> To: Linux OMAP ML
> Subject: Zoom, crop and scaling v4l2 device capabilities
>
> Hello all,
>
>
>   I'm currently starting to work with v4l. I'm not sure if this is
> the right place to post this question, but as this group has relation
> with v4l, I'll try also here.
>
>   The question is about digital zoom capabilities. I'm a little
> confused about how to implement crop related ioctls in a v4l2 driver.
>
>   First of all, what is the common application flow to probe zoom
> capabilities from
> a v4l2 driver? What is the common application flow to get and set
> current zoom
> settings from a v4l2 driver? AFAIU, applications must combine
> VIDIOC_CROPCAP, VIDIOC_[S,G]_CROP with VIDIOC_[S,G]_FMT.
> What application is a good example for this issue?
>
>   Suppose a device which supports following modes:
> - mode 1 (640, 480),
> - mode 2 (320, 240) from window (0,0) to (640, 480) and
> - mode 3 (320, 240) from  window (161, 121) to (480, 360)
>
>   What is the best way to implement this support? I can see at least
> one option here: export the bounds and defrect for cropcap as 640x480.
> When applications request formats, return to them what best fits
> between 640x480 or 320x240. And then, when applications request crop
> window modification, the behaviour would be, if they request a crop
> window equal to defrect, the device is changed to mode 1 or 2
> (depending on the current format).  however if the crop window
> requested is smaller then defrect, the mode 3 is configured. Is this
> behaviour expected or I misunderstood something?
>
>
> Cheers,
>
> --
> Eduardo Bezerra Valentin
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


-- 
Eduardo Bezerra Valentin
