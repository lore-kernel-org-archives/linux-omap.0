From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2: Camera: Add driver.
Date: Thu, 23 Aug 2007 15:51:37 +0300
Message-ID: <46CD82D9.3070708@nokia.com>
References: <46C982CD.80802@nokia.com>	
	<11876114351486-git-send-email-sakari.ailus@nokia.com>
	<5d5443650708211008x11d022b6qe513e75c6aa56585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650708211008x11d022b6qe513e75c6aa56585@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext Trilok Soni wrote:
> Hi Sakari,

Hello Trilok,

>> +       switch (p.if_type) {
>> +       case V4L2_IF_TYPE_PARALLEL:
>> +               if (p.u.parallel.frame_start_on_rising_vs)
>> +                       cam->cc_ctrl |= CC_CTRL_NOBT_SYNCHRO;
>> +               if (p.u.parallel.bt_sync_correct)
>> +                       cam->cc_ctrl |= CC_CTRL_BT_CORRECT;
>> +               if (p.u.parallel.swap)
>> +                       cam->cc_ctrl |= CC_CTRL_PAR_ORDERCAM;
> 
> In case of earlier omap2 camera driver with ov9640 combination above bit was
> set based on the pixelformat being passed. I am just copying that code here.
> 
> -----------------------snip-------------------------------------
>         switch (pix->pixelformat) {
>         case V4L2_PIX_FMT_UYVY:
>         case V4L2_PIX_FMT_RGB565:
>         case V4L2_PIX_FMT_RGB555:
>         default:
>                 /* These formats need a 16-bit byte swap */
>                 cam->cc_ctrl |= CC_CTRL_PAR_ORDERCAM;
>         case V4L2_PIX_FMT_YUYV:
>         case V4L2_PIX_FMT_RGB565X:
>         case V4L2_PIX_FMT_RGB555X:
>                 /* These formats don't need a 16-bit byte swap */
>                 break;
>         }

Ah. I didn't anticipate this... Then probably the camera driver needs to 
call g_ifparm always after s_fmt_cap.

> So, we might need to add support for above also.
> 
>> +               if (p.u.parallel.latch_clk_inv)
>> +                       cam->cc_ctrl |= CC_CTRL_PAR_CLK_POL;
>> +               if (p.u.parallel.nobt_hs_inv)
>> +                       cam->cc_ctrl |= CC_CTRL_NOBT_HS_POL;
>> +               if (p.u.parallel.nobt_hs_inv)
> 
> Above should be nobt_vs_inv instead :)

You got me convinced. :)

> I have updated ov9640 driver with the changes you have suggested and
> with new "ifparm" bits, but ov9640 on H4 is still not working. I will
> post that incremental patches for ov9640, so that someone can debug on
> H4/OMAP1(once that core gets converted to this new interface).

Ok.

-- 
Sakari Ailus
sakari.ailus@nokia.com
