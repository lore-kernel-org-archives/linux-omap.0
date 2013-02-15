From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/1] drivers: net: davinci_cpdma: acknowledge
 interrupt properly
Date: Fri, 15 Feb 2013 15:20:25 -0500 (EST)
Message-ID: <20130215.152025.1605170079652952030.davem@davemloft.net>
References: <1360866406-17261-1-git-send-email-mugunthanvnm@ti.com>
	<20130215.150506.499818568035818118.davem@davemloft.net>
	<1360959539.21068.5.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1360959539.21068.5.camel@joe-AO722>
Sender: netdev-owner@vger.kernel.org
To: joe@perches.com
Cc: mugunthanvnm@ti.com, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Joe Perches <joe@perches.com>
Date: Fri, 15 Feb 2013 12:18:59 -0800

> On Fri, 2013-02-15 at 15:05 -0500, David Miller wrote:
>> From: Mugunthan V N <mugunthanvnm@ti.com>
>> Date: Thu, 14 Feb 2013 23:56:46 +0530
>> 
>> > +enum {
>> > +     CPDMA_EOI_RX_THRESH = 0,
>> > +     CPDMA_EOI_RX,
>> > +     CPDMA_EOI_TX,
>> > +     CPDMA_EOI_MISC,
>> > +};
>> 
>> Do not use enumerations for hardware register values, which must be
>> exact, otherwise you are potentially going to succumb to the vagaries
>> of C language enumeration value assignment.
> 
> Vagaries?
> 
> In what way is c enumeration (6.7.2.2) vague?
> char vs int?  Isn't smaller mostly better?
> 
> Concern about possible future reordering given an
> insertion or deletion might be the only consideration
> I could imagine.

Right.  That's why you should use explicit CPP defines for
register offsets and values.
