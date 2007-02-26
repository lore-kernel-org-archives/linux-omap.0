From: Khem Raj <kraj@mvista.com>
Subject: Re: osk 5912 tftpboot problem
Date: Mon, 26 Feb 2007 14:11:30 -0800
Message-ID: <45E35B12.6000907@mvista.com>
References: <5d18bc9a0702261344g7d40d0f9gc9796e57bfb9870e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <5d18bc9a0702261344g7d40d0f9gc9796e57bfb9870e@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Piotr Filipiuk <piotr.filipiuk@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Piotr Filipiuk wrote:
> Hi,
> While trying to send uImage to the board by tftp I get following message:
>
> OMAP5912 OSK # tftpboot 0x10000000 uImage
> TFTP from server 192.168.1.2; our IP address is 192.168.1.3
> Filename 'uImage'.
> Load address: 0x10000000
> Loading: T T T T T T T T T T
> Retry count exceeded; starting again
> TFTP from server 192.168.1.2; our IP address is 192.168.1.3
> Filename 'uImage'.
> Load address: 0x10000000
> Loading: T T T T T T T T T T
> Abort
>
> Could anyone explain me what is the problem...
your tftp server might not be set properly.  Check your /etc/xinetd.d/tftp
check if you have in.tftp daemon pointing to right place and also couple 
of other params like below.

service tftp
disable                 = no
server_args          = /tftpboot

restart xinetd
and then put your uImage under /tftpboot/ on your host.
