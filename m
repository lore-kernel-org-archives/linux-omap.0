From: Sakari Ailus <sakari.ailus@nokia.com>
Subject: Re: [PATCH 1/2] ov9640: Add OmniVision ov9640 driver - new interface
Date: Mon, 20 Aug 2007 12:07:42 +0300
Message-ID: <46C959DE.2010306@nokia.com>
References: <5d5443650708180136o56e3cfc8t458a7071d88c0288@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650708180136o56e3cfc8t458a7071d88c0288@mail.gmail.com>
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
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

ext Trilok Soni wrote:
> Hi All,

Hi, Trilok!

> I have attached two patches which converts the ov9640 driver to use
> the new v4l2 sensor interface. Sensor detection is working with H4 but
> the output is not anywhere near to correct, so someone with H4 please
> check and give inputs.
> 
> Patches are implemented and tested against mainline kernel and OMAP2
> camera driver posted by Sakari to v4l mailing list [1].

 > +#define NUM_IOCTLS 16
...
 > +     /* Just an experiment --- don't use *_cb functions yet. */
 > +     ov9640_ioctl_desc[i++] = vidioc_int_dev_init_cb(&ioctl_dev_init);
 > +     BUG_ON(i >= NUM_IOCTLS);

These are leftovers from the check-slave-interface-types experiment 
which probably should be removed. This applies to TCM825x as well.

-- 
Sakari Ailus
sakari.ailus@nokia.com
