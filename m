From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: Some possible missing v4l2_subdev IOCTLs.
Date: Fri, 20 Mar 2009 08:19:17 +0100
Message-ID: <200903200819.18011.hverkuil@xs4all.nl>
References: <A24693684029E5489D1D202277BE89442E6B1E33@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <A24693684029E5489D1D202277BE89442E6B1E33@dlee02.ent.ti.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, "camera@ok.research.nokia.com" <camera@ok.research.nokia.com>, "Menon, Nishanth" <nm@ti.com>, "Lakhani, Amish" <amish@ti.com>, "Nagalla, Hari" <hnagalla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Friday 20 March 2009 03:24:49 Aguirre Rodriguez, Sergio Alberto wrote:
> Hi Hans,
>
> I did a quick analysis of the subdev, and noticed that some video ioctls
> for the subdevices aren't there...
>
> [gs]_crop
> [gs]_parm
> enum_frameintervals
> enum_framesizes
> enum_fmt_cap
>
> I noticed this because we currently use them for a "best sensor output"
> selection before sending the image to the OMAP3 ISP.
>
> Any particular reason why these aren't there?

Because no other i2c drivers needed them until now. I try to avoid adding 
code that nobody is using. 

Note that gs_parm was just added. And in video_ops there is already an 
enum_fmt. Feel free to add crop and the enum_frame* ops. If you mail me a 
patch, then I'll commit it.

Regards,

	Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
