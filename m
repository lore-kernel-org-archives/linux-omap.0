From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: [PATCH] MMC: OMAP R6 response support
Date: Thu, 25 Jan 2007 16:19:29 +0100
Message-ID: <45B8CA81.5080802@drzeus.cx>
References: <45B8B6D9.90006@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45B8B6D9.90006@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: "linux- >> omap-linux" <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Carlos Aguiar wrote:
> Hi folks,
>
> Regarding the commit below
>
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6f949909e8f9e5d7e5584dc48d9a5e060c52aed1
> ,
>
> the definition of response type R6 is the same as R1 and case
>   

That is intentional. All specs I have state that they have the same format.

> MMC_RSP_R6 was removed on omap.c, causing a error when inserting a SD
> card on OMAP platforms.
>   

Do you have a dump I could see?

> This error occur due following the MMC and SD specs, on CMD3, response
> type is R6 to SD cards and R1 to MMC cards.
>
> So, I'm proposing a patch that try to solve this problem. I've tested
> it with SD and MMC cards and looks fine.
>
>   

NAK. Opcodes should never be present in host drivers. It completely
kills forward compatibility. This should be fixed by figuring out what
the OMAP hardware does differently and do a general solution from that.

Rgds

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
