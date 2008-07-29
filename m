From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 0/4] OMAP: MENELAUS: Improvements on menelaus
Date: Tue, 29 Jul 2008 12:44:19 -0400
Message-ID: <488F48E3.2060504@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:63002 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbYG2QpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2008 12:45:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony and folks,

This patch series proposes some improvements on menelaus code.

Basically it makes menelaus to use macros instead of some magic constant 
numbers, making menelaus code more legible. The menelaus header was 
moved to include/linux/i2c and register map (including the macros 
created) were moved to include/linux/i2c/menelaus.h

Tested with MMC on N800 and looks fine.

BR,

Carlos.

PS: I would like to thanks Felipe Balbi for hints and orientation.

-- 
Carlos Eduardo Aguiar
Software Engineer
Mobile Linux Software
Nokia Institute of Technology - INdT
Phone: +55 92 2126-1079
Mobile: +55 92 8127-1797
E-mail: carlos.aguiar@indt.org.br

