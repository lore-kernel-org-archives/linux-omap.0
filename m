From: Steve Poulsen <spoulsen@css-design.us>
Subject: Re: OMAP5910 GPIO configuration
Date: Tue, 27 Mar 2007 14:01:32 -0500
Message-ID: <46096A0C.4060605@css-design.us>
References: <31154.18749.qm@web30604.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <31154.18749.qm@web30604.mail.mud.yahoo.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Zgembo Adislic <adislic_zgembo@yahoo.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Zgembo,

I would recommend you make a simple driver that uses either ioctl or 
file operations.  The driver will read/write to the GPIO registers and 
talk to your user application via the ioctl or file ops.

Steve

Zgembo Adislic wrote:
> Hello,
>
> Does anyone have some tutorials/examples on how to configure OMAP5910 GPIO pins from user space?   
>
> Tnx,
> Zgembo Adislic
>
>  
> ---------------------------------
>  Get your own web address.
>  Have a HUGE year through Yahoo! Small Business.
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>   
