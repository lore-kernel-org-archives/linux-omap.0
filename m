From: David Singleton <dsingleton@mvista.com>
Subject: Re: mcount unresolved symbol - build module with
Date: Mon, 04 Dec 2006 10:31:23 -0800
Message-ID: <4574697B.4000901@mvista.com>
References: <13ECC251745F8F4BA0076A980813C7C29F1055@msl-ex02.corp.m-sys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <13ECC251745F8F4BA0076A980813C7C29F1055@msl-ex02.corp.m-sys.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eyal Shani <Eyal.Shani@SanDisk.Com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Eyal Shani wrote:

>Mohammed,
>
> 
>
>It seems that all these steps were already taken by my driver.
>
>Still, this mcount is Unknown symbol for the module.
>  
>

mcount is a routine introduced when you compile with profiling flags 
turned on.

Are you sure your module and your kernel were built with the same config 
options?


> 
>
>I am not sure exactly what this symbol is for, too.
>
> 
>
>Any idea how I can introduce this symbol to the module?
>
>Again, this is in MobiLinux 4.1 for 2430SDP.
>
> 
>
>Thanks in advance,
>
>Eyal Shani
>
> 
>
>
>______________________________________________________________________
>This email has been scanned by the MessageLabs Email Security System.
>For more information please visit http://www.messagelabs.com/email 
>______________________________________________________________________
>_______________________________________________
>Linux-omap-open-source mailing list
>Linux-omap-open-source@linux.omap.com
>http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>  
>
