From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: DSP support on current git
Date: Mon, 13 Nov 2006 21:08:15 +0100
Message-ID: <85bqnbw1n4.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

In my quest in getting the current -omap kernel working on my n770, I
found that the DSP was not working. (fwiw, it's working fine with the
kernel from nokia).

When Nokia's tool tries to download code into the DSP, it fails. I've
also some error messages in the logs like : 

"kernel: omapdsp: TLB is full."
"kernel: omapdsp: DSP address 00403ff4 / size 00000004 is not valid!"
"kernel: omapdsp: address 400000 not found in exmap_tbl."

(see http://lechat.rtp-net.org/misc/omapdsp_log)

So, I'm wondering if someone with an omap1 board has got working the DSP
on current git tree or not. 


Regards,
Arnaud
