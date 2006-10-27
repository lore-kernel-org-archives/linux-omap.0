From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: Git tree updated to 2.6.19-rc2
Date: Fri, 27 Oct 2006 17:30:04 +0200
Message-ID: <454225FC.8060000@gmail.com>
References: <20061023203925.GC11967@atomide.com> <453E3C75.6060605@gmail.com>
	<20061027125013.GB25245@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20061027125013.GB25245@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

tony@atomide.com wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [061024 19:16]:
> 
>>Tony Lindgren wrote:
>>
>>>- CONFIG_DEBUG_LL hangs system
>>
>>For reference see
>>
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008025.html
>>
>>and
>>
>>http://linux.omap.com/pipermail/linux-omap-open-source/2006-October/008054.html
>>
>>for an ugly workaround if you really need it. I really have
>>no clue what is broken here.
> 
> 
> Sounds like some clock is not enabled somewhere and serial write hangs.

Good idea! I think we had some clock rework meanwhile. Maybe 
we have to move a clock enable to some earlier point if 
using CONFIG_DEBUG_LL. Any idea which clock is worth looking at?

Best regards

Dirk
