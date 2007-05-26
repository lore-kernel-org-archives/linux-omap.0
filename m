From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 1/2] OMAP: Kill compile warnings
Date: Sat, 26 May 2007 07:38:01 +0200
Message-ID: <4657C7B9.1050704@googlemail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47FF0C4E@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47FF0C4E@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>, nishanth menon <menon.nishanth@gmail.com>, Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Syed Mohammed, Khasim wrote:
>> That would be redundant:
>> 220         /* Get the debug Device */
>> 221         dbg_dev = &(pdev->dev);
>> already did that for you.. only, now the messages will show
>> "input:xyz.." instead of "omap_twl4030:xyz"..
> 
> OK, thanks. 
> 
> Acked-by: x0khasim@ti.com

Okay, after 2 minutes thinking about what's so confusing here, I have
it now. We have two different patches with nearly identical subject.
The first one should fix a warning we already discussed under an other
subject. A answer to the second patch was sent under the subject of
the first one ;) Therefore some clarification as I understand it now:

We have two warnings:

1) Section mismatch with sys_timer

This is what "[PATCH 1/2] OMAP: Kill compile warnings" is about.

As mentioned by Tony this patch isn't correct and we will wait (as
discussed already earlier) until this is fixed by ignore list.

http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010087.html

http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010061.html

2) Warning in twl4030 keypad about dbg_dev

This is what "[PATCH 2/2] OMAP: Kill compile warnings" is about.

For this we already had an other subject in the list archives as well
"Compiler warning in omap-twl4030keypad.c".

Above Khasim acked it (with misleading subject ;) ) and I also think
it's okay

http://linux.omap.com/pipermail/linux-omap-open-source/2007-May/010086.html

Acked-by: Dirk Behme <dirk.behme@gmail.com>

Conclusion: For (1) we have to wait, for (2) please apply.

Hope that helps a little,

Dirk
