From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: Re: [PATCH 00/17] Massive OMAP730/OMAP850 cleanup
Date: Thu, 15 Oct 2009 01:12:52 +0100
Message-ID: <3d374d00910141712o6db73c8ejf2e49e4a65b758d6@mail.gmail.com>
References: <3d374d00910141250h22e18bccpa6792d2a323b61f8@mail.gmail.com>
	<20091014211206.GL12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20091014211206.GL12700@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

2009/10/14 Tony Lindgren <tony@atomide.com>:
> * Alistair Buxton <a.j.buxton@gmail.com> [091014 13:03]:
>> Reposting the full series for review. Assuming this is all OK would it
>> be a good idea to merge the config variables into a single
>> CONFIG_ARCH_OMAP7XX? There doesn't seem to be any reason to have both.
>> Original description follows.
>
> Yeah, those should be merged too. Let's do that as a separate patch.

On a related note, the omap850.h and omap730.h should go away too,
when everyone is happy with the new omap7xx.h. Perhaps we should add a
#warning to them so people know they will be removed at some point?

-- 
Alistair Buxton
a.j.buxton@gmail.com
