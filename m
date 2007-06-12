From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: Re: [PATCH 3/12] Add an option to disable debug UART.
Date: Tue, 12 Jun 2007 23:42:29 +0200
Message-ID: <466F1345.8090703@free.fr>
References: <466AE1C3.8090506@free.fr> <20070612132154.GD28834@atomide.com>
	<20070612133623.GG28834@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070612133623.GG28834@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi,

Tony Lindgren wrote:
>> Hmm, is the extra + before busyuart above intentional?
>>     
>
> I guess I should be looking at the updated patch set instead...
>   
Yes, sorry for the mess...
Most of the syntactic mistakes still apply though, so I'll update my 
patches to take them into account.

I've just noticed I've forgotten to use 'struct kp_key' for a few boards in
'[PATCH 11/12] Add support for keys setting multiple bits in the scan', 
so I'll fix that as well.

Concerning patches which add new config options such as in
'[PATCH 3/12] Add an option to disable debug UART.', should I also 
provide a patch to update all defconfigs or is it ok not to do so?

Thanks for your time,
Vivien.
