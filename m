From: "arun c" <arun.edarath@gmail.com>
Subject: dspbios/link on 2430
Date: Fri, 14 Sep 2007 15:18:00 +0530
Message-ID: <c656a4d20709140248y7b45b113xb4e66bb53b821585@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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

Hi all,

I have a working linux kernel on 2430 sdp board.
I want to use dspbios/link on my board(to say the truth i only know
that its somthing that will allow arm to control dsp).

I have compiled the DSPBIOS/Link against my kernel.
I inserted the module dsplinkk.ko sucessfully. But the
testsuite is failing (means link is not proper i guess)

I want to know what interface clocks and functional
clocks must be enabled in X-loader(or in uboot or in kernel)
inorder for the link to work properly on the board?.
I use boot from nand option on SDP.

Or i have to switch on only interface and funtional clocks to
IVA2.1?

Regards
arunc
