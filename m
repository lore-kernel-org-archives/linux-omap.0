From: Ram <vshrirama@gmail.com>
Subject: sd cards support on osk5912
Date: Mon, 10 Apr 2006 02:53:15 -0700
Message-ID: <8bf247760604100253k2dfa2c70pd4e000341ceefb75@mail.gmail.com>
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
   I have kernel sources 2.6.16 for mmc/sd card support. MMC/SD
Drivers are present in
   drivers/mmc.


   The MMC/SD Card  Support (Platform init routinues) are there for
innovator board.
    (board-innovator.c).

   If i want OSK to support SD (SD I/F is on a addon board to OSK)

  What changes i need to make in the kernel sources so that drivers
can access SD  cards.

  Please Advice,

  Regards,
   sriram
