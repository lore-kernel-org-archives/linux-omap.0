From: "Piotr Filipiuk" <piotr.filipiuk@gmail.com>
Subject: U-Boot problem (OSK5912)
Date: Mon, 19 Feb 2007 23:05:19 +0100
Message-ID: <5d18bc9a0702191405x62518d10y9f520e2885b17661@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,
To initiate a kermit download from U_Boot I type loadb. Then in kermit I
type:
(/home/filip/) C-Kermit>send /bin
/home/filip/montavista/kernel/linux/arch/arm/boot/uImage

I reveive messages:

Return to your local Kermit and give a RECEIVE command.

KERMIT READY TO SEND...
SENT: (0 files) +

*************************
SEND-class command failed.
Packets sent: 2
Retransmissions: 11
Timeouts: 12
Damaged packets: 0
Fatal Kermit Protocol Error: Too many retries

HINTS... If the preceding error message does not explain the failure:
. Adjust the timeout method (see HELP SET SEND).
. Increase the retry limit (see HELP SET RETRY).
. Try it again with SET STREAMING OFF.
. Try it again with SET PARITY SPACE.
. As a last resort, give a ROBUST command and try again.
Also:
. Be sure the source file has read permission.
. Be sure the target directory has write permission.
(Use SET HINTS OFF to suppress hints.)
*************************

Could anyone help me with loading the kernel from host?

./kermrc looks like this:

set line /dev/ttyS0
set speed 115200
set carrier-watch off
set handshake none
set flow-control none
robust
set file type bin
set file name lit
set rec pack 1000
set send pack 1000
set window 5
