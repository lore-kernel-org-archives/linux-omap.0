From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: How to upload u-boot to H3 with serial port ?
Date: Thu, 31 Aug 2006 22:12:47 -0500
Message-ID: <44F7A52F.3030402@gmail.com>
References: <A794DE2F81AEF94099397C9D7D5B651E5FB107@dlee08.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <A794DE2F81AEF94099397C9D7D5B651E5FB107@dlee08.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Kipisz, Steven" <s-kipisz2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Greeting Miao/Amit
>> I want upload u-boot to H3, but I don't have JTAG and CCS, I only have
>> serial port.

CCS,Lauterbach, USB.. And.... There is supposedly a "poor man's"
approach... ;)
There is OST host(some name to that effect) tool which should be usable
over serial port... if you are lucky enough to get the box in which the
h3 came with, then it hides innocently in a CD in it...

http://linux.omap.com/pub/documentation/P2_NAND_boot_support.txt

can help you started though it is for P2.. but note that this was
written sometime back... things have changed since then, but most
probably not about OST host - if u can flash u-boot to flash.. Ur good
to GO :)!!

If you cant find OST host... u could contact your TI contact person for it..

Regards,
Nishanth Menon
