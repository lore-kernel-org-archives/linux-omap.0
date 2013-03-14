From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v3 net-next 1/1] drivers: net: davinci_cpdma: acknowledge
 interrupt properly
Date: Thu, 14 Mar 2013 15:51:23 +0530
Message-ID: <5141A4A3.4050204@ti.com>
References: <1361175560-600-1-git-send-email-mugunthanvnm@ti.com> <51404838.2040008@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <51404838.2040008@mimc.co.uk>
Sender: netdev-owner@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 3/13/2013 3:04 PM, Mark Jackson wrote:
> On 18/02/13 08:19, Mugunthan V N wrote:
>> >CPDMA interrupts are not properly acknowledged which leads to interrupt
>> >storm, only cpdma interrupt 0 is acknowledged in Davinci CPDMA driver.
>> >Changed cpdma_ctlr_eoi api to acknowledge 1 and 2 interrupts which are
>> >used for rx and tx respectively.
>> >
>> >Reported-by: Pantelis Antoniou<panto@antoniou-consulting.com>
>> >Signed-off-by: Mugunthan V N<mugunthanvnm@ti.com>
> Not sure if I'm seeing this same problem [1], but it doesn't appear fixed to me.
>
> I've tried both mainline -rc2 and -next.
>
> [1]https://lkml.org/lkml/2013/3/12/376
Without this patch, PG2.0 was not usable as CPSW interrupt was never acked
and CPU spent most of the time in CPSW ISR.

I have checked -rc2 and it is working fine.

Regards
Mugunthan V N
