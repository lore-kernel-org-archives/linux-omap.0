From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] ARM: OMAP2: Camera: Adapt to 2.6.20.
Date: Thu, 1 Mar 2007 10:58:18 +0530
Message-ID: <5d5443650702282128v6d3e7ab6jff886249e300db6e@mail.gmail.com>
References: <45E5A489.2040108@nokia.com>
	<11726783562347-git-send-email-sakari.ailus@nokia.com>
	<11726783562842-git-send-email-sakari.ailus@nokia.com>
	<11726783561918-git-send-email-sakari.ailus@nokia.com>
	<1172678356543-git-send-email-sakari.ailus@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1172678356543-git-send-email-sakari.ailus@nokia.com>
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
To: Sakari Ailus <sakari.ailus@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 2/28/07, Sakari Ailus <sakari.ailus@nokia.com> wrote:
> Signed-off-by: Sakari Ailus <sakari.ailus@nokia.com>
> ---
>  drivers/media/video/omap/omap24xxcam-sensor.c |    6 ++++--
>  drivers/media/video/omap/omap24xxcam.c        |   12 +++++++-----
>  drivers/media/video/omap/omap24xxcam.h        |    2 +-
>  3 files changed, 12 insertions(+), 8 deletions(-)
>

I think you have not looked at patches posted by me about OMAP2420
camera. Part of the changes are taken from N800 kernel tree and TI's
tree. Those sensor interface changes are also changed to adapt TI
Micron sensor. I believe you should have worked on those changes and
modified sensor interface for N800. Why re-work?

http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009062.html
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009063.html
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009069.html
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009064.html
http://linux.omap.com/pipermail/linux-omap-open-source/2007-February/009065.html

Please help me to review above patches instead, then we will have less
re-work and come to conclusion, whose patches should be integrated
instead. BTW, I have N800 so I can test this sensor now.

-- 
--Trilok Soni
