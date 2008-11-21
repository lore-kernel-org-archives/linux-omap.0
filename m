From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 2/2] TVP514x V4L int device driver support
Date: Fri, 21 Nov 2008 17:16:14 +0100
Message-ID: <200811211716.14072.hverkuil@xs4all.nl>
References: <hvaibhav@ti.com>
	<1227280923-31654-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <1227280923-31654-1-git-send-email-hvaibhav@ti.com>
Content-Disposition: inline
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: video4linux-list@redhat.com
Cc: linux-omap@vger.kernel.org, davinci-linux-open-source-bounces@linux.davincidsp.com
List-Id: linux-omap@vger.kernel.org

On Friday 21 November 2008 16:22:03 hvaibhav@ti.com wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> Added new V4L2 slave driver for TVP514x.
>
> The Driver interface has been tested on OMAP3EVM board
> with TI daughter card (TVP5146). Soon the patch for Daughter card
> will be posted on community.
>
> Signed-off-by: Brijesh Jadav <brijesh.j@ti.com>
> 		Hardik Shah <hardik.shah@ti.com>
> 		Manjunath Hadli <mrh@ti.com>
> 		R Sivaraj <sivaraj@ti.com>
> 		Vaibhav Hiremath <hvaibhav@ti.com>
> 		Karicheri Muralidharan <m-karicheri2@ti.com>
> ---
>  drivers/media/video/Kconfig   |   11 +
>  drivers/media/video/Makefile  |    1 +
>  drivers/media/video/tvp514x.c | 1331
> +++++++++++++++++++++++++++++++++++++++++ include/media/tvp514x.h    
>   |  406 +++++++++++++
>  4 files changed, 1749 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/media/video/tvp514x.c
>  create mode 100644 include/media/tvp514x.h
>

I'll review this today or tomorrow.

Regards,

	Hans

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
