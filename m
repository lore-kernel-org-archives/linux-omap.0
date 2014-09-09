From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [resend PATCH 0/3] Add DRA7xx CPSW Ethernet support in Device
 Tree
Date: Tue, 9 Sep 2014 16:59:52 +0530
Message-ID: <540EE4B0.70207@ti.com>
References: <1410203998-8700-1-git-send-email-mugunthanvnm@ti.com> <20140908193440.GC12150@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140908193440.GC12150@kahuna>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 09 September 2014 01:04 AM, Nishanth Menon wrote:
> On 00:49-20140909, Mugunthan V N wrote:
>> > Adding device tree entry for CPSW to make it work in Dual EMAC mode.
>> > 
>> > These patches were tested with DRA7 hwmod patches on top of linux-next.
>> > The patches were already reviewed [1] and has been waiting for cross bar
>> > and hwmod to be pulled in. Now since all dependent patches has already
>> > pulled in, so reposting the patches again.
>> > 
>> > Patches are tested on linux-next, the boot logs on DRA7xx EVM [2]
>> > 
>> > [1] https://lkml.org/lkml/2014/5/13/89
>> > [2] http://slexy.org/view/s2YqO0Wj9b 
> Sorry this is now blocked inside TI. could you explain the testing done
> for sleep state? did you attempt sleep mode before testing this?
> 

I have not tested sleep mode, just tested boot and ping test.

Regards
Mugunthan V N
