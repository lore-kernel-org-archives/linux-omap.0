From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
Date: Thu, 01 Sep 2011 11:34:17 +0100
Message-ID: <4E5F5FA9.3010305@arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>	<1314804471.2344.79.camel@deneb.redhat.com>	<4E5E5D80.6080409@arm.com>
	<201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201108311855.27711.marc.dietrich@ap.physik.uni-giessen.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
Cc: Russell King <linux@arm.linux.org.uk>, Greg KH <greg@kroah.com>, "ming.lei@canonical.com" <ming.lei@canonical.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, Mark Salter <msalter@redhat.com>, Chen Peter-B29397 <B29397@freescale.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Marc,

On 31/08/11 17:55, Marc Dietrich wrote:
> Am Mittwoch 31 August 2011, 18:12:48 schrieb Marc Zyngier:
>> [...]
>> Oddly enough, this patch doesn't do anything on my Tegra setup. In both
>> cases, I get around 17MB/s from a crap SD card plugged in a USB reader.
>>
>> This leads me to suspect that this issue is very much OMAP4 specific.
>> Can anyone verify this theory on other some A9 platforms?
> 
> That's odd. On my Tegra2 (on ac100) it boosts the transfer rate from 7 to 
> 17 MB/s. 

I'm using a Harmony board. Could you share your kernel version, .config
and dmesg?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
