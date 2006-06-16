From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: Plea for MMC spec owners
Date: Fri, 16 Jun 2006 13:04:19 +0200
Message-ID: <44929033.8050706@drzeus.cx>
References: <00da01c689c3$dca1b110$c7a3580a@swcenter.sec.samsung.co.kr>
	<4486A60C.6020804@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4486A60C.6020804@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Anyone?

Pierre Ossman wrote:
> First off, thanks a bundle for all the help.
> 
> Now I was hoping that you could check one final thing before I scurry
> off. :)
> 
> SD cards have a command (ACMD22) that reports the number of successfully
> written blocks. This allows us to do multi-block writes safely, even
> with deep pipelines. The MMC specs I have do not mention anything
> similar, so this currently seems to be a SD-only feature. Could you guys
> have a look if something along these lines have shown up in the later
> versions?
> 
> Rgds
> Pierre
> 
