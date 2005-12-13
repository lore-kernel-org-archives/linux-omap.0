From: Anderson Briglia <anderson.briglia@indt.org.br>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Date: Tue, 13 Dec 2005 18:27:34 -0400
Message-ID: <439F4AD6.9090203@indt.org.br>
References: <20051213213208.303580000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20051213213208.303580000@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Anderson Lizardo <anderson.lizardo@indt.org.br>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

[resending summary because our first attempt failed]

Hi,

These series of patches add support for MultiMediaCard (MMC) password
protection, as described in the MMC Specification v4.1. This feature is
supported by all compliant MMC cards, and used by some devices such as Symbian
OS cell phones to optionally protect MMC cards with a password. Password length
is limited to 16 bytes.

By default, a MMC card with no password assigned is always in "unlocked" state.
After password assignement, in the next power cycle the card switches to a
"locked" state where only the "basic" and "lock card" command classes are
accepted by the card. Only after unlocking it with the correct password the
card can be normally used for operations like block I/O.

Password management and caching is done through the "Kernel Key Retention
Service" mechanism and the sysfs filesystem. The Key Retention Service is used
for (1) unlocking the card, (2) assigning a password to an unlocked card and
(3) change a card's password. To remove the password and check locked/unlocked
status, a new sysfs attribute was added to the MMC driver.

Along with this thread will be sent a script that tests all possible user
scenarios described above. Also will be attached a tarball containing a simple
text-only reference UI to demonstrate how to manipulate the password.

TODO:

- MMC hotplugging needs to be extended to properly call probe() for the
  different MMC drivers (currently only mmc_block). Currently, the block driver
  is not notified in any way that the card was unlocked.

- Password caching: when inserting a locked card, the driver should try to
  unlock it with the currently stored password (if any), and if it fails,
  revoke the key containing it and fallback to the normal "no password present"
  situation.

- Currently, some host drivers assume the block length will always be a power
  of 2. This is not true for the MMC_LOCK_UNLOCK command, which is a block
  command that accepts arbitratry block lengths. We have made the necessary
  changes to the omap.c driver (present on the linux-omap tree), but the same
  needs to be done for other hosts' drivers.

Known Issue:

- Some cards have an incorrect behaviour (hardware bug?) regarding password
  acceptance: if an affected card has password <pwd>, it accepts <pwd><xxx> as
  the correct password too, where <xxx> is any sequence of characters, of any
  length. In other words, on these cards only the first <password length> bytes
  need to match the correct password.

Comments or suggestions are welcome.

--
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar

Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
