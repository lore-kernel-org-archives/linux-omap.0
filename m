From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone-common: Fix mmc0 Write Protect
Date: Tue, 3 Jul 2018 05:23:45 -0500
Message-ID: <CAOCHtYjki+_qGUXzweTwNCdqfG-Z0kLmq+HqpqFZ8dB14fy_yA@mail.gmail.com>
References: <20180702202143.25343-1-robertcnelson@gmail.com>
 <20180703062419.GB112168@atomide.com>
 <6c0eb111-a301-d6c9-46c9-7bc45c82511c@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <6c0eb111-a301-d6c9-46c9-7bc45c82511c@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: devicetree <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Drew Fustini <drew@beagleboard.org>, Jason Kridner <jkridner@beagleboard.org>, linux-omap <linux-omap@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 3, 2018 at 1:31 AM, Faiz Abbas <faiz_abbas@ti.com> wrote:
> Hi,
>
> On Tuesday 03 July 2018 11:54 AM, Tony Lindgren wrote:
>> * Robert Nelson <robertcnelson@gmail.com> [180702 20:24]:
>>> Mainline Commit b74c2b21e1551018af53ee6c1efc051dfce2d788 added the pinmux
>>> settings for mmc1, however this pin (0x9a0) is routed to P9_42 on the cape
>>> header. Thus any BeagleBone cape that utilizes P9_42 triggers mmc0's Write
>>> Protect.
>>
>> Thanks applying into omap-for-v4.18/fixes. I'll also add a Fixes tag for
>> it.
>>
>
> The evm sk sdwp needs to be removed as well. I guess I'll post a
> separate patch as this is already applied.

Yeah, i don't have an evm sk, while i found found one schematic that
made it look okay, wasn't 100% sure on all the revisions..

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
