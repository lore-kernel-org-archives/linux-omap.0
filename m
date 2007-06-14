From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH 5 / 12] Board 3430 SDP file
Date: Thu, 14 Jun 2007 12:39:46 +0530
Message-ID: <5d5443650706140009i312cbdc4xbeda22cce5b4511f@mail.gmail.com>
References: <001901c7ae50$23ba5820$e1ac580a@swcenter.sec.samsung.co.kr>
	<002601c7ae51$b4068a60$128918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <002601c7ae51$b4068a60$128918ac@ent.ti.com>
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
To: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>, kmpark@infradead.org
List-Id: linux-omap@vger.kernel.org

On 6/14/07, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com> wrote:
> Hi,
>
> >To disable the wire4 mode, you should assign the value 0 instead of -1. The
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
