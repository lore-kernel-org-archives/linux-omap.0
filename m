From: Bryan Wu <bryan.wu@analog.com>
Subject: How to port the musb to a new processor?
Date: Wed, 29 Aug 2007 17:27:14 +0800
Message-ID: <1188379634.5910.8.camel@roc-desktop>
Reply-To: bryan.wu@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Tony and David,

There days, I am trying to enable musb stack in my Blackfin Linux tree.
After comparing the musb_regs.h with the BF54x USB register layout, I
found it is not very easy to use the musb_regs.h for the porting.

1. Offset of the musb_regs.h is different with the BF54x
2. Some musb_regs are 8-bit wide, while on BF54x most of them are 16-bit
or 32-bit.
3. Some register not in BF54x and some BF54x register is not in
musb_reg.h

But most BF54x USB register can found one in musb_regs.h

I just wondering how to abstract this definition to BF54x hardware as
Davinci or OMAP does.

Thanks a lot
Best Regards,

- Bryan Wu
