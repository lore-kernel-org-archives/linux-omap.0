From: "Jason Huang" <jason.huang@wescongroup.com>
Subject: Touchscreen build on Innovator 1510
Date: Thu, 19 Jan 2006 12:28:22 -0800
Message-ID: <014101c61d36$e45bf8b0$6cfea8c0@wescongroup.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello,
When I built 2.6.15-omap1 with TOUCHSCREEN_OMAP enabled, the build failed in
drivers/ssi/omap-tsc2101.c. 
When TOUCHSCREEN_OMAP enabled, OMAP_TSC2101 is enabled as well and
drivers/ssi/omap-tsc2101.c is built. However, omap-tsc2101.c is reserved for
1610 etc.

Has anyone built 2.6.14/2.6.15 for OMAP1510 with TOUCHSCREEN enabled?

Best regards.

Jason Huang

-------------------------------------------
drivers/ssi/omap-tsc2101.c:42:5: warning: "CONFIG_ARCH_OMAP16XX" is not
defined
drivers/ssi/omap-tsc2101.c:45:2: #error "Unsupported configuration"
drivers/ssi/omap-tsc2101.c: In function `omap_tsc2101_write':
drivers/ssi/omap-tsc2101.c:136: warning: implicit declaration of function
`omap_uwire_data_transfer'
drivers/ssi/omap-tsc2101.c: In function `omap_tsc2101_configure':
drivers/ssi/omap-tsc2101.c:222: error: `UWIRE_READ_RISING_EDGE' undeclared
(first use in this function)
drivers/ssi/omap-tsc2101.c:222: error: (Each undeclared identifier is
reported only once
drivers/ssi/omap-tsc2101.c:222: error: for each function it appears in.)
drivers/ssi/omap-tsc2101.c:222: error: `UWIRE_WRITE_RISING_EDGE' undeclared
(first use in this function)
drivers/ssi/omap-tsc2101.c:224: warning: implicit declaration of function
`omap_uwire_configure_mode'
make[2]: *** [drivers/ssi/omap-tsc2101.o] Error 1
make[1]: *** [drivers/ssi] Error 2
make: *** [drivers] Error 2
