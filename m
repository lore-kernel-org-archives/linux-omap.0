From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Thu, 15 Jul 2010 08:34:50 +0300 (EEST)
Message-ID: <20100715.083450.193689911.Hiroshi.DOYU@nokia.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
	<20100714132255.GB3103@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100714132255.GB3103@ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, pavel@ucw.cz
Cc: khilman@deeprootsystems.com, teerth@ti.com, linux-pm@lists.linux-foundation.org, Yoshiya.Hirase@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: ext Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Wed, 14 Jul 2010 15:22:55 +0200

> Hi!
> 
>> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
>> 
>> Hibernation (a.k.a: Suspend-To-Disk) support for ARM
>> 
>> Based on the original work from Romit and Raghu at TI. The original
>> patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>
>> 
>> *1: https://patchwork.kernel.org/patch/96442/
>> 
>> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> Looks ok to me. ACK.

Pavel, Thanks.

Russell, would it be possible to put this into your next merge queue?
