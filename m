From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 21:33:41 +0100
Message-ID: <456F4025.5010403@gmail.com>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
	<456F1B1E.1050305@gmail.com>
	<200611301114.09352.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200611301114.09352.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell wrote:
> BTW, please examine the appended patch to consider updating the
> merge candidate.

Mmh, maybe I'm wrong here or anything is long term 
misconfigured, but looks to me that I don't get a login 
prompt with this patch and rt applied. With [1] I get

-- cut --

Kernel boot message ...
...
Loading modules ...
...
Welcome to OSK (ARM926T) - Kernel 2.6.19-rc6-rt3-omap1 (ttyS0).

OSK login: root
login[992]: root login  on `ttyS0'

BusyBox v1.00 (2005.01.31-19:22+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

#
-- cut --

With your patch instead [1], everything including output of 
/etc/issue ("Welcome...") is missing. Module output is still 
there.

Strange.

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008370.html
