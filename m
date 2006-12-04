From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 5/5] [RFC] Add MMC Password Protection (lock/unlock)
 support V7: mmc_omap_dma.diff
Date: Mon, 04 Dec 2006 12:22:18 -0400
Message-ID: <45744B3A.7050502@indt.org.br>
References: <4564648B.2020005@indt.org.br> <456805F3.1020407@drzeus.cx>
	<456AEB70.2000100@indt.org.br> <45709C93.7050709@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <45709C93.7050709@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ext Pierre Ossman wrote:
> Anderson Briglia wrote:
>> This patch is needed only for lock/unlock commands. So, it's necessary to
>> make MMC omap works when using that feature. It's not a generic patch.
>> But I can take off this one from the series and send after (if) the
>> series
>> is integrated.
>>
> 
> The patches are marked "[RFC]" which I interpret as that I shouldn't
> merge it. Is this incorrect?

Yes, you're right. But I believe this code is almost "ready" to be applied, do
you agree?
The next series I'll send without the "[RFC]" mark, what do you think?

> 
>> frame depends on data->blksz. When we were using data->blksz_bits
>> everything was
>> ok because we always had a multiple of 16 bits (2 bytes). Once a pwd
>> can has a size
>> not multiple of 2, the value must be rounded.
>> According to MMC OMAP Technical Reference Manual, because of each DMA
>> transfer is of
>> equal size, it is necessary to have the block size of the transfer be
>> a multiple of
>> the DMA write access size (which is 2 bytes).
>>
> 
> This sounds very generic and not something that is specific to the
> password command.

I'm still investigating where is the problem.
Actually this patch will not be included on the next series, as you
suggested. But it is still needed to make MMC lock/unlock works for
OMAP.

Best regards,

Anderson Briglia
