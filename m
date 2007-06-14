From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [PATCH 5 / 12] Board 3430 SDP file
Date: Thu, 14 Jun 2007 13:34:09 +0530
Message-ID: <002a01c7ae5a$96cb6430$128918ac@ent.ti.com>
References: <5d5443650706140009i312cbdc4xbeda22cce5b4511f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d5443650706140009i312cbdc4xbeda22cce5b4511f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: 'Trilok Soni' <soni.trilok@gmail.com>
Cc: 'Linux OMAP' <linux-omap-open-source@linux.omap.com>, kmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

>I have hard time to understand above sentence. Do you mean new mmc
>driver file for 3430 or you mean adding some #ifdefery in existing
>mmc.c ?
The mmc controller in 2430/3430 is a new one which is very much different
from the omap1 mmc controller. The register set does not match. So, it makes
sense to write a new driver (I mean a different file) to support 2430/3430.

BTW,
Sorry about the wire4 mode. It should be set to "1" as the 3430 sdp can
support 4-bit.

Trilok,
I am not referring to mmc.c. I am referring to the mmc controller driver
omap.c.

Regards,
Madhu

-----Original Message-----
From: Trilok Soni [mailto:soni.trilok@gmail.com] 
Sent: Thursday, June 14, 2007 12:40 PM
To: Madhusudhan Chikkature Rajashekar
Cc: kmpark@infradead.org; Syed Mohammed, Khasim; Linux OMAP
Subject: Re: [PATCH 5 / 12] Board 3430 SDP file

On 6/14/07, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com> wrote:
> Hi,
>
> >To disable the wire4 mode, you should assign the value 0 instead of -1.
The
> >"-1" will enable the wire4 mode in the code.
> Yes. Ideally it should have been set to 0.
>
> But, note that the mmc_omap_probe you are referring here is of omap1 and
> omap2(only 2420) driver. The above is a 3430 board file, so it might not
> have that effect.
>

I have hard time to understand above sentence. Do you mean new mmc
driver file for 3430 or you mean adding some #ifdefery in existing
mmc.c ?

-- 
--Trilok Soni
