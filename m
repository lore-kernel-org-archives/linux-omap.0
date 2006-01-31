From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [patch 0/6] Add MMC password protection (lock/unlock) support V4
Date: Tue, 31 Jan 2006 16:16:36 -0400
Message-ID: <20060131201636.264543000@localhost.localdomain>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751456AbWAaU0S@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, "Linux-omap-open-source@linux.omap.com" <linux-omap-open-source@linux.omap.com>
Cc: linux@arm.linux.org.uk, David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Russell King <rmk+lkml@arm.linux.org.uk>, "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>, "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>, Anderson Briglia <anderson.briglia@indt.org.br>
List-Id: linux-omap@vger.kernel.org

Hi all,

New in this version:

- The remaining MMC password operations previously executed by key
  retention functions (change password, unlock card and assign password)
  were implemented using the sysfs mechanism.
- Added the host MMC lock/unlock capability support for OMAP platform.
- Added verbose debugging messages

This series of patches add support for MultiMediaCard (MMC) password
protection, as described in the MMC Specification v4.1. This feature is
supported by all compliant MMC cards, and used by some devices such as
Symbian OS cell phones to optionally protect MMC cards with a password.

By default, a MMC card with no password assigned is always in "unlocked"
state. After password assignment, in the next power cycle the card
switches to a "locked" state where only the "basic" and "lock card"
command classes are accepted by the card. Only after unlocking it with
the correct password the card can be normally used for operations like
block I/O.

Password management and caching is done through the "Kernel Key
Retention Service" mechanism and the sysfs filesystem. A new sysfs
attribute was added to the MMC driver for unlocking the card, assigning
a password to an unlocked card, change a card's password, remove the
password and check locked/unlocked status.

A sample text-mode reference UI written in shell script (using the
keyctl command from the keyutils package), can be found at:

http://www.indt.org.br/10le/mmc_pwd/mmc_reference_ui-20060130.tar.bz2

TODO:

- Password caching: when inserting a locked card, the driver should try
  to unlock it with the currently stored password (if any), and if it
  fails, revoke the key containing it and fallback to the normal "no
  password present" situation.

Known Issue:

- Some cards have an incorrect behaviour (hardware bug?) regarding
  password acceptance: if an affected card has password <pwd>, it
  accepts <pwd><xxx> as the correct password too, where <xxx> is any
  sequence of characters, of any length. In other words, on these cards
  only the first <password length> bytes need to match the correct
  password.


We would like to ask you to test these patches. We believe they are
ready to be included on the kernel source.

Comments and suggestions are welcome.
--
Anderson Briglia,
Anderson Lizardo,
Carlos Eduardo Aguiar
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
