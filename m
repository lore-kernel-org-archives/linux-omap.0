From: Ran Shalit <ranshalit@gmail.com>
Subject: Is there a way to force probe to be called (etherned driver) ?
Date: Sun, 24 Jul 2016 11:51:20 +0300
Message-ID: <CAJ2oMh+mjySAQbOEmkQGvfO+JmC-mdQ3HBEFRViA-vpEGeTJQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-omap@vger.kernel.org

Hello,


I write ethernet driver (mac controller is implemented in fpga connected to cpu)

I see that the probe is not called on doing insmod.

Is there a way to force the probe to be called on doing insmod ?

I could not find in the board file (omap dart, kernel 3.4.0) any
reference to ethernet.


Best Regards,

Ran
