From: Komal Shah <komal_shah802003@yahoo.com>
Subject: ARM: OMAP: Add external LCD controller support for DSP Gateway
Date: Tue, 21 Feb 2006 12:24:19 -0800 (PST)
Message-ID: <20060221202419.7898.qmail@web32902.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

Juha,

+			status = omapfb_unregister_client(omapfb_nb);
+			if (!status)
+				printk("omapfb_unregister_client(): "
+				       "success\n");
+			else
+				printk("omapfb_runegister_client(): "
+				       "failure(%d)\n", status);

You might want to add KERN_WARNING or KERN_INFO for above printks and
other locations of printks in the patch where it is missing.

+	}
+	//printk("calling omapfb_update_window_async()\n");
+	omapfb_update_window_async(&win, fbupd_cb, NULL);

c++ style comment. May be you would like to remove that printk itself.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
