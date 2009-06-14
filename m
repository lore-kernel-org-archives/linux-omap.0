From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: tcm825x.c: migrating to sub-device framework? (was: TVP514x: Migration to sub-device framework)
Date: Sun, 14 Jun 2009 16:32:21 +0200
Message-ID: <200906141632.21098.hverkuil@xs4all.nl>
References: <hvaibhav@ti.com> <200906141214.38355.hverkuil@xs4all.nl> <200906141444.54105.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <200906141444.54105.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, Brijesh Jadav <brijesh.j@ti.com>, Hardik Shah <hardik.shah@ti.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 14 June 2009 14:44:53 Hans Verkuil wrote:
> On Sunday 14 June 2009 12:14:38 Hans Verkuil wrote:
> > On Wednesday 06 May 2009 20:31:33 hvaibhav@ti.com wrote:
> > > From: Vaibhav Hiremath <hvaibhav@ti.com>
> > > 
> > > This patch converts TVP514x driver to sub-device framework
> > > from V4L2-int framework.

Now that tvp514x is converted to using v4l2_subdev (pending a few small final
tweaks) there is only one driver left that uses the v4l2-int-device.h API:
tcm825x.c.

What is involved in converting this driver as well? And who can do this?

Regards,

	Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
