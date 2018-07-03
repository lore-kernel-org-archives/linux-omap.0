From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone-common: Fix mmc0 Write Protect
Date: Tue, 3 Jul 2018 12:01:17 +0530
Message-ID: <6c0eb111-a301-d6c9-46c9-7bc45c82511c@ti.com>
References: <20180702202143.25343-1-robertcnelson@gmail.com>
 <20180703062419.GB112168@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180703062419.GB112168@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Drew Fustini <drew@beagleboard.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Kridner <jkridner@beagleboard.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tuesday 03 July 2018 11:54 AM, Tony Lindgren wrote:
> * Robert Nelson <robertcnelson@gmail.com> [180702 20:24]:
>> Mainline Commit b74c2b21e1551018af53ee6c1efc051dfce2d788 added the pinmux
>> settings for mmc1, however this pin (0x9a0) is routed to P9_42 on the cape
>> header. Thus any BeagleBone cape that utilizes P9_42 triggers mmc0's Write
>> Protect.
> 
> Thanks applying into omap-for-v4.18/fixes. I'll also add a Fixes tag for
> it.
> 

The evm sk sdwp needs to be removed as well. I guess I'll post a
separate patch as this is already applied.

Thanks,
Faiz
