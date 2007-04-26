From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: patch to enable mtd partitions in omap5912 for 2.6.8.
Date: Thu, 26 Apr 2007 07:19:55 -0500
Message-ID: <463098EB.6030006@css-design.us>
References: <46305277.90802@mindtree.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46305277.90802@mindtree.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Zaheer <zaheer_mugad@mindtree.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Zaheer,

Does 2.6.8 have problems with MTD?  If not, you should just be able to 
enable it in the kernel config.  Look at arch/arm/mach-omap1/board-osk.c 
as well.

Steve

Zaheer wrote:
> Hello,
>
> Can anyone provide me with a patch for enabling MTD partitions on 
> omap5912 osk for 2.6.8 kernel.
>
> Thanks,
> Zaheer
>
>
> DISCLAIMER:
> This message (including attachment if any) is confidential and may be 
> privileged. Before opening attachments please check them for viruses 
> and defects. MindTree Consulting Limited (MindTree) will not be 
> responsible for any viruses or defects or any forwarded attachments 
> emanating either from within MindTree or outside. If you have received 
> this message by mistake please notify the sender by return  e-mail and 
> delete this message from your system. Any unauthorized use or 
> dissemination of this message in whole or in part is strictly 
> prohibited.  Please note that e-mails are susceptible to change and 
> MindTree shall not be liable for any improper, untimely or incomplete 
> transmission.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
