From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [PATCH Resend 0/3] ARM: OMAP: Patches adding TWL4030 USB
	support and MUSB support on 34xx
Date: Fri, 14 Dec 2007 12:17:28 -0800
Message-ID: <87r6hpm3on.fsf@vence.hilman.org>
References: <010C7BAE6783F34D9AC336EE5A01A088050666AF@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <010C7BAE6783F34D9AC336EE5A01A088050666AF@dbde01.ent.ti.com>
	(Anand Gadiyar's message of "Fri\, 14 Dec 2007 19\:26\:57 +0530")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-omap-open-source <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

"Gadiyar, Anand" <gadiyar@ti.com> writes:

> Patch 3:
> Updated with fixes to comments by Felipe Balbi
> and Kevin Hilman.

FYI...  Host mode still not quite working on my 3430SDP ES1, but
haven't looked into the details.

Kevin

root@omap3430sdp:~# mkdir -p /media/usb                                           
root@omap3430sdp:~# mount -t msdos /dev/sda1 /media/usb                           
coot@omap3430sdp:~# dd if=/dev/urandom of=/media/usb/rand.bin bs=1M count=8; sync
8+0 records in                                                                    
8+0 records out                                                                   
8388608 bytes (8.4 MB) copied, 10.977 seconds, 764 kB/s                           
                                                                                  
musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 2103                 
musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 2103                 
musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 2103                 
musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 2103                 
musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 2103                 
musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 2103                 
musb_h_tx_flush_fifo 124: Could not flush host TX fifo: csr: 2103                 
[...]
