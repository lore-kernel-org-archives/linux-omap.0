From: Ram <vshrirama@gmail.com>
Subject: SDRAM clock changes ?
Date: Mon, 6 Feb 2006 10:54:40 +0530
Message-ID: <8bf247760602052124s701cf35n9596d9202f5702b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
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
   I want to change the sdram setting from 96 MHZ to 192MHZ in OMAP.

  What registers need to be modified for effecting this.



  I went through the data sheets and there is no single place where
it is listed - the values of   different sdram clock rates.

i have made the required changes in the DPLL control register (PLL_MULT Bit=
s).

In addition to this what other changes i need to make ?.



 Any help is highly appreciated.


Thanks,


Regards,
sriram
