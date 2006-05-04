From: Matt Callow <mc-lists@tesco.net>
Subject: Re: Problems in OMAP 1510 Camera sensor code
Date: Thu, 04 May 2006 22:28:30 +0100
Message-ID: <445A71FE.8070904@tesco.net>
References: <ade4abe50604180321w6a25159cyfea3cdf01e89f4b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ade4abe50604180321w6a25159cyfea3cdf01e89f4b1@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

RAVI SHANGAR wrote:

>Previously, I got info about the 1510 camera driver that sensor_ov9640.c
>must be modified for our ov66xx sensor.
>  
>
Which sensor are you trying to support?  i am working on a driver for
the ov6650

>...
>
>The second doubt I have is the slave address for I2C driver used in ov9640.h
>
>If OMAP_24xx_VIRTIO defined , addr is 0x60 or it is 0x30.
>
>But in iBootHost given with OMAP board, Camera code uses 0x60 as the addr.
>  
>
For all the OV sensors I've seen (which it not that many!) the  default
slave address is 0x60

Matt
