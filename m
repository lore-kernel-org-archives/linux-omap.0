From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: osk5912bsl.lib has incompatible ABI
Date: Fri, 18 May 2007 15:20:15 -0500
Message-ID: <464E0A7F.5000006@css-design.us>
References: <64263.30576.qm@web56107.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <64263.30576.qm@web56107.mail.re3.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Amr Ayoub <amrgermany@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Amr,

Did you get this resolved?

Are you using CCS to build?  You need to make sure all libraries you are 
using, and your source code compile options, have a matching ABI.   
Check your compile options ABI first and see if you can find one that 
works.  You can also remove libraries and add them one by one because I 
think the ABI error will show up before unresolved symbols shows up.

Steve


Amr Ayoub wrote:
> Dear all,
>
> I have a linking error which says "'C:\CCStudio_v3.1\boards\osk5912\lib\osk5912bsl.lib' has
> incompatible ABI ".
>
> I have read the URL that was posted by Thomas Maughan to Alex Schneidman but still got the same error.
> ftp://ftp.ti.com/pub/private-cs/armcgt_releases/tms470_releases.html
>
> Could you please brief me with the solution.
>
> Best regards,
> Amr Ayoub
>
>
>
>        
> ____________________________________________________________________________________Building a website is a piece of cake. Yahoo! Small Business gives you all the tools to get online.
> http://smallbusiness.yahoo.com/webhosting 
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>   
