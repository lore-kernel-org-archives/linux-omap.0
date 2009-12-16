From: "Weng, Wending" <WWeng@rheinmetall.ca>
Subject: OMAP3 I2C driver timing problem with multiple messages transfer
Date: Wed, 16 Dec 2009 09:54:11 -0500
Message-ID: <54B31811B83D744D90BF0289EB447D4609975E46F1@MAIL-MB1.oerlikon.ca>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx.rheinmetall.ca ([207.61.105.111]:15597 "EHLO
	MAIL-ET.oerlikon.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752166AbZLPOyN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 09:54:13 -0500
In-Reply-To: <1260972144-31593-1-git-send-email-virtuoso@slind.org>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Hi All,

        Some I2C related protocols as SMBus, each command is composed of multiple I2C messages with timing constraint, the delay between two messages must be less than 10 ms, otherwise, the SMBus device will be timeout, and the command fails. As the function wait_for_completion_timeout is used to wait the end of a message, it doesn't guarante the next message will be sent out in 10 ms after the previous message is completed, so the SMBus command fails very often. I developped a patch for fixing this timing problem(2.6.32.RC5), is there anybody willing to review and to incorporate the patch into the furture release?

Wending
Software Engineer
at Rheinmetall Canada
