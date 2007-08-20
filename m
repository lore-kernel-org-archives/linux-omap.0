From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 0/2] Updated OMAP 2 camera driver and N800 platform
	camera patches
Date: Mon, 20 Aug 2007 22:29:06 +0530
Message-ID: <5d5443650708200959u7de311e2m1eda814ecc2e1540@mail.gmail.com>
References: <46C982CD.80802@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <46C982CD.80802@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Sakari,

On 8/20/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
> Hi,
>
> Here are the new OMAP 2 camera driver and N800 platform camera patches.
> I have posted the updates to V4L int if and TCM825x driver to the V4L
> list already as they have been integrated into V4L tree at
> <URL:http://linuxtv.org/hg/v4l-dvb> (excluding the new patches, sorry).
>
> The changes since the last update include the following:
>
> - Update to use vidioc_int_g_ifparm.
>
> - VIDIOC_DQBUF fix.
>
>      The driver assumed that every slave would return zero from
>      vidioc_int_g_needs_reset. This doesn't hold true for the slaves that
>      do not implement that ioctl at all.
>
> - Small cleanups, remove useless & characters.

Thanx for the update. I will rebase ov9640 code with above v4l2-int
changes and test with this updated omap2 camera driver.

-- 
--Trilok Soni
