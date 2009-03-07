From: Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 9/9] omap34xxcam: Add camera driver
Date: Sat, 07 Mar 2009 17:38:17 +0300
Message-ID: <1236436697.1863.21.camel@tux.localhost>
References: <49AD0128.5090503@maxwell.research.nokia.com>
	 <1236074816-30018-1-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-2-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-3-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-4-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-5-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-6-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-7-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-8-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236074816-30018-9-git-send-email-sakari.ailus@maxwell.research.nokia.com>
	 <1236101460.10927.109.camel@tux.localhost>
	 <49AFDD0B.80804@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <49AFDD0B.80804@maxwell.research.nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, saaguirre@ti.com, tuukka.o.toivonen@nokia.com, dongsoo.kim@gmail.com
List-Id: linux-omap@vger.kernel.org

Hello, Sakari Ailus

On Thu, 2009-03-05 at 16:09 +0200, Sakari Ailus wrote:
> Alexey Klimov wrote:
> >> +static int vidioc_g_fmt_vid_cap(struct file *file, void *fh,
> >> +				struct v4l2_format *f)
> >> +{
> >> +	struct omap34xxcam_fh *ofh = fh;
> >> +	struct omap34xxcam_videodev *vdev = ofh->vdev;
> >> +
> >> +	if (vdev->vdev_sensor == v4l2_int_device_dummy())
> >> +		return -EINVAL;
> >> +
> >> +	mutex_lock(&vdev->mutex);
> >> +	f->fmt.pix = vdev->pix;
> >> +	mutex_unlock(&vdev->mutex);
> > 
> > Hmmmm, you are using mutex_lock to lock reading from vdev structure..
> > Well, i don't if this is right approach. I am used to that mutex_lock is
> > used to prevent _changing_ of members in structure..
> 
> The vdev->mutex is acquired since we want to prevent concurrent access 
> to vdev->pix. Otherwise it might change while we are reading it, right?

I thought more about this and looks like that i was wrong. You are
right. You are reading structure, and i wasn't able to notice that first
time. Sorry for bothering about this.

<snip>

> >> +static int omap34xxcam_device_register(struct v4l2_int_device *s)
> >> +{
> >> +	struct omap34xxcam_videodev *vdev = s->u.slave->master->priv;
> >> +	struct omap34xxcam_hw_config hwc;
> >> +	int rval;
> >> +
> >> +	/* We need to check rval just once. The place is here. */
> > 
> > I didn't understand this comment. You doing nothin in next few lines
> > with int variable rval(which introduced in this function). Is comment
> > talking about struct v4l2_int_device *s ?
> 
> Yes. If the g_priv() succeeds now it will succeed in future, too. This 
> comes from the platform data through the slave device.

Well, okay. I mean that for me this comment looks ambiguous. Please, if
you don't mind it's better not to use word "rval" because it  creates
confusion with int rval;.


-- 
Best regards, Klimov Alexey

