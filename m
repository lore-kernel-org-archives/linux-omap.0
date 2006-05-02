From: Eduardo Gallofin <egallofin@yahoo.com>
Subject: init (busybox) problem on OSK5912
Date: Tue, 2 May 2006 00:09:52 -0700 (PDT)
Message-ID: <20060502070952.51594.qmail@web52312.mail.yahoo.com>
References: <20060501170002.24B3A8062B@linux.omap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060501170002.24B3A8062B@linux.omap.com>
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

   I have just ported the 2.6.16 kernel to the OSK and
it works fine together with the rootfs available at
the omap website. However, i tried compiling busybox
(1.00 and 1.1.2) for OMAP and used it, but the OSK
seems to hang up after "Freeing init memory: 120K".

   Do you have any ideas where it might have gone
wrong?

  Thanks.

Ed

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
