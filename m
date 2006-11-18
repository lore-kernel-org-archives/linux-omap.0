From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix Apollon and OSK ethernet IRQ flags
Date: Sat, 18 Nov 2006 07:09:30 +0100
Message-ID: <455EA39A.1040008@gmail.com>
References: <455C93A5.8010203@gmail.com> <20061117214618.GG6072@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20061117214618.GG6072@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Dirk Behme <dirk.behme@googlemail.com> [061116 18:46]:
> 
>>Fix IRQ flags for Apollon and OSK (OMAP5912) board.
...
> Heh, thanks pushing today. Did I manage to break any other boards? :)

Thanks for pushing! Looking at defconfigs we have 
CONFIG_SMC91X=y for innovator_1610, innovator_1510, h2, h3, 
h4, osk, 2430sdp, apollon and perseus2. Except perseus2 all 
boards should be covered now.

Hint: perseus2 is worth a check ;)

Dirk
