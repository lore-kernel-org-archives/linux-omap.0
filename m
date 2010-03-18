From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: patch series versioning: please keep version numbers consistent
Date: Thu, 18 Mar 2010 08:07:14 -0700
Message-ID: <87ocilmzx9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45521 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385Ab0CRPHS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 11:07:18 -0400
Received: by pva4 with SMTP id 4so1146136pva.19
        for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 08:07:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

If you are using version numbering in your patch series, please be
sure to update the version number for *all patches* in series.  Even
if only one patch of the series has changed in the updated series,
please update the version number for all patches.  Having different
version numbers within a series is confusing, and is more difficult to
follow when using automated tools such as patchworks.

Keeping versioning consistent is easy when using 'git format-patch'.
Simply use the --subject-prefix option to add a version number, and it
will be added to every patch in the series.  For example

  $ git format-patch -o tmp --subject-prefix='PATCH v3' <start>..<until>

Will ensure that all the subjects have the same versioning.

Kevin
