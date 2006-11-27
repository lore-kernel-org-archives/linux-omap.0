From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 4/5] [RFC] Add MMC Password Protection (lock/unlock)
 support V7: mmc_sysfs.diff
Date: Mon, 27 Nov 2006 07:31:42 -0400
Message-ID: <456ACC9E.2030105@indt.org.br>
References: <45646457.1060203@indt.org.br> <45680555.1000406@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <45680555.1000406@drzeus.cx>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pierre,

ext Pierre Ossman wrote:
> Patch looks ok. But I never got an answer what the difference between
> "change" and "assign" is.

You're right, the command is the same, but the difference is the password's
length and password itself sent to the card.
According to MMC spec 4.1, when a password replacement is done, the length value
(PWD_LEN) shall include both passwords, the old and the new one, and the password
(PWD) shall include the old (currently) followed by the new password.

Best Regards,

Anderson Briglia
