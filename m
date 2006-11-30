From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: CONFIG_PREEMPT_RT patch on OSK
Date: Thu, 30 Nov 2006 20:43:43 +0100
Message-ID: <456F346F.8030906@gmail.com>
References: <455EBA92.5050804@gmail.com>
	<a0580c510611301012t3985c696q88834c4960acdf8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <a0580c510611301012t3985c696q88834c4960acdf8f@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Eduardo Valentin <edubezval@gmail.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Eduardo Valentin wrote:
> [   16.829315] BUG: scheduling while atomic: IRQ 160/0x00000001/709, CPU#0
> [   18.828186] NETDEV WATCHDOG: eth0: transmit timed out
> [   21.828155] NETDEV WATCHDOG: eth0: transmit timed out
> 
>   Have you already faced this problem? 

As mentioned in [1] I doubt ethernet as well. For test 
purposes I boot using ramdisk instead of NFS, so I had no 
network/NFS access at boot time. Then, I manually mounted 
NFS from user space and played MP3 via NFS [1].

Anybody with a hint for non-experts what "BUG: scheduling 
while atomic" wants to tell us? Any idea what is wrong here? 
IRQ 160 is our GPIO  eth0 interrupt.

Dirk

[1] 
http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008490.html
