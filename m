From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC][PATCH 0/6] OMAP1: CAMERA: Converts omap1 camera to use
	v4l2-int-device api
Date: Mon, 22 Oct 2007 12:01:00 +0530
Message-ID: <5d5443650710212331h5eb19241l40d33e6e70a149f3@mail.gmail.com>
References: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1191934353-24072-1-git-send-email-edubezval@gmail.com>
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
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap-mailing-list <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Eduardo,

On 10/9/07, Eduardo Valentin <edubezval@gmail.com> wrote:
> Hi all,
>
> This patch set converts omap1 camera to use v4l2-int-device api. It was
> tested on H3 with ov9640 sensor, so board-h3.c was modified to add ov9640
> specific initializations. The gpio-expander code was modified also to use
> the i2c adapter id configured with i2c board specific info. Currently, it is
> working only with read method. To work with MMAP, camera_core.c needs more
> re-work.
>
> Here is the overall diffstat:
>  b/arch/arm/mach-omap1/board-h3.c         |  141 +++++++++
>  b/drivers/i2c/chips/gpio_expander_omap.c |    5
>  b/drivers/media/video/omap/Kconfig       |    6
>  b/drivers/media/video/omap/Makefile      |    4
>  b/drivers/media/video/omap/camera_core.c |  394 ++++++++++++++++++---------
>  b/drivers/media/video/omap/camera_core.h |   27 -
>  b/drivers/media/video/omap/omap16xxcam.c |  442 +++++++++++++++----------------
>  drivers/media/video/omap/camera_core.c   |  404 +++++++++++++---------------
>  8 files changed, 827 insertions(+), 596 deletions(-)
>

Thanx for sending OMAP1 changes to fit with new framework. So, it
looks like that new ov9640.c is ready for upstream.

-- 
--Trilok Soni
