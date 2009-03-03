From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [REVIEW PATCH 09/14] OMAP: CAM: Add ISP Core
Date: Tue, 03 Mar 2009 09:09:07 +0200
Message-ID: <49ACD793.7000505@nokia.com>
References: <Acl1IyATAKAzUiSPQiOOAI2yzi0iWQ==>	
	<A24693684029E5489D1D202277BE894416429F9F@dlee02.ent.ti.com>
	<5e9665e10903020009y7fe7d0d0j356708e1c3149cac@mail.gmail.com>
Reply-To: sakari.ailus@maxwell.research.nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <5e9665e10903020009y7fe7d0d0j356708e1c3149cac@mail.gmail.com>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: "DongSoo(Nathaniel) Kim" <dongsoo.kim@gmail.com>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "Toivonen Tuukka.O (Nokia-D/Oulu)" <tuukka.o.toivonen@nokia.com>, "Nagalla, Hari" <hnagalla@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

DongSoo(Nathaniel) Kim wrote:
> Hello,
> 
> reviewing ISP driver, I found that we've got no querymenu support in
> ISP and also omap3 camera interface driver.
> 
> +/**
> + * struct vcontrol - Video control structure.
> + * @qc: V4L2 Query control structure.
> + * @current_value: Current value of the control.
> + */
> +static struct vcontrol {
> +       struct v4l2_queryctrl qc;
> +       int current_value;
> +} video_control[] = {
> 
> <snip>
> 
> +       {
> +               {
> +                       .id = V4L2_CID_PRIVATE_ISP_COLOR_FX,
> +                       .type = V4L2_CTRL_TYPE_INTEGER,
> +                       .name = "Color Effects",
> +                       .minimum = PREV_DEFAULT_COLOR,
> +                       .maximum = PREV_BW_COLOR,
> +                       .step = 1,
> +                       .default_value = PREV_DEFAULT_COLOR,
> +               },
> +               .current_value = PREV_DEFAULT_COLOR,
> +       }
> +};

I don't see these lines in Sergio's patch you replied to. I have 
V4L2_CTRL_TYPE_MENU there instead of V4L2_CTRL_TYPE_INTEGER.

> I think we should make it menu type for this color FX control.
> If that kind of control has no menu information, user has no way to
> figure out what kind of FX supported by device.
> BTW if we make querymenu support in omap3 camera subsystem, we should
> make querymenu support for v4l2 int device also.
> I think I've seen before a patch which intent to use querymenu in v4l2
> int device, but no patch for omap3 ISP and camera interface.
> Can I make a patch and post on linux-omap, linux-media list? of course
> if you don't mind.
> Or...am I digging wrong way? I mean.. querymenu for omap3 camera subsystem.
> Please let me know :)

I'm always happy to get patches. :-) But my understanding is that 
querymenu is implemented in ISP and camera drivers --- though I haven't 
tried it myself.

Cheers,

-- 
Sakari Ailus
sakari.ailus@maxwell.research.nokia.com

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
